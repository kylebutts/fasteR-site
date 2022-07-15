---
layout: "../layout/PostLayout.astro"
lesson: false
toc_num: 40
---
 
## <a name="ide"> Installing and Using IDEs </a>

An *interactive development environment* (IDE) is a software tool that
enables editing, saving and running your code, as well as related
actions such as installing packages.

The real "power users" tend to use either Emacs Speaks Statistics (ESS),
a plugin for the Emacs editor, or Nvim-r,, a plugin for the vim editor.
However, since this tutorial is aimed at those with little or no prior
coding background, we will not cover them.  Instead, we introduce 
RStudio.  Here are some pros and cons:

* RStudio is very highly popular, especially in the US and Australia/New
  Zealand.  Indeed, for many users, RStudio *is* R.  

* Lots of help available on the Web, and in R User Groups that have been
  established in many major cities.  Has numerous features, keyboard
shortcuts etc.  

* That however also has a downside, since as noted earlier, the
  compexity of RStudio can be "overwhelming."

In light of that last point, we recommend that you NOT try to learn
RStudio to any degree of complexity at the outset.  Just learn how to
create, load, run, and save files of R code, the simple stuff, which
should be easy.  Leave the advanced features for later.

### Installation

There are many tutorials on the Web for installing RStudio.   
[This one](https://techvidvan.com/tutorials/install-r/) is pretty good, 
for all major platforms.

### Startup

If your screen has an RStudio icon, click it.  Otherwise type 'rstudio'
into a terminal window.

### Basic actions:

Again, there is a lot more one can do than the following, but we'll
stick to the absolute basics.

Note the pane in the lower-left portion of the RStudio screen.  By
default, that is the Console pane, containing the usual R '>' prompt.
You can use it just as we have throughout this tutorial.  Note too that
this is where your R output will appear.

Everything here involves files, where we store our R code (*scripts*).

**creating a new code file:**  File | New File | R Script will create an
empty window pane, ready to be filled with code.  Start typing!

**saving a code file:** File | Save will save the contents of the pane.
If it's a new file, you'll be asked to give the file a name.  Make sure
to note what folder the file will be in, so you know where to read it
from later.

**running code:** To run the code in your current window, choose Code |
Run Region | Run All.

**exiting RStudio:**

File | Quit Session...


## LICENSING

The document is covered by a 
[Creative Commons](http://creativecommons.org/licenses/by-nd/3.0/us/) license,
Creative Commons Attribution-No Derivative Works 3.0 United States 
![alt text](http://i.creativecommons.org/l/by-nd/3.0/us/88x31.png).  I have
written the document to be *used*, so readers, teachers and so on are
very welcome and encouraged to copy it verbatim.  Copyright is retained
by N. Matloff in all non-U.S. jurisdictions, but permission to use these
materials in teaching is still granted, provided the authorship and
licensing information here is displayed.  I would appreciate being
notified if you use this book for teaching, just so that I know the
materials are being put to use, but this is not required.  information
displayed.  No warranties are given or implied for this material.
