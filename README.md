# fasteR Website

This repository converts these [intro to R lecture notes](https://github.com/matloff/fasteR) into a website using [Astro](https://astro.build). 

The build steps are as follows:

1. Source `utils/download_fasteR.R` to create `src/pages/*.md`.
2. Run `astro build` to create the html files in the `dist` folder.
