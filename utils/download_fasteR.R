library(here)
library(glue)
library(data.table)
library(stringr)
library(jsonlite)

# text <- xfun::read_utf8("https://raw.githubusercontent.com/matloff/fasteR/master/README.md")
text <- xfun::read_utf8(here::here("public/README.md"))
text <- text[-1]

# Update colors
text <- str_replace_all(text, '<span style="color:red">', '<span style="color: #b4637a;">')



idx <- str_detect(text, "^## ")
# First h2 should not be it's own file it's part of the introduction
idx[min(which(idx))] <- FALSE
idx[max(which(idx))] <- FALSE


# Split level 2 headers to sections
text <- split(text, cumsum(idx))

# Remove TOC 
text[[2]] <- NULL

# chapter <- text[[3]]
# header <- chapter[1]

TOC = lapply(seq_along(text), \(i) {
  
  chapter <- text[[i]]
  
  # Get slug and filename
  header <- chapter[1]
  slug <- str_match(header, '<a name="(.*)"')[,2]
  if(is.na(slug)) slug <- "index"

  # Get if is a lesson
  lesson <- str_match(header, "Lesson ([0-9]{1,2}): (.*)")[, 2] 
  lesson <- as.numeric(lesson)

  if(!is.na(lesson)) {
    title <- str_match(header, "Lesson ([0-9]{1,2}): (.*)")[, 3] 
    title <- str_squish(title)
  } else {
    if(slug == "index") {
      title <- "fasteR: Fast Lane to Learning R!"
    } else {
      title <- str_match(header, ">(.*?)</a>")[, 2]
      title <- str_squish(title)
    }
  }

  if(!is.na(lesson)) {
    filename <- glue("src/pages/{sprintf('%02d', lesson)}-{slug}.md")
  } else {
    filename <- glue("src/pages/{slug}.md")
    lesson <- "false"
  } 

  # Frontmatter to include at top of md file
  frontmatter <- c(
    '---',
    'layout: "../layout/PostLayout.astro"',
    paste('lesson:', lesson),
    paste('toc_num:', i),
    '---',
    ' ' 
  )
  
  chapter <- c(frontmatter, chapter)
  
  chapter |>
    paste(collapse = "\n") |>
    cat(file = here(filename))

  return(list(
    lesson = lesson, toc_num = i, filename = filename, slug = slug, title = title
  ))
})

jsonlite::toJSON(TOC, pretty = T, auto_unbox = T) |> 
  cat(file = here("public/TOC.json"))

