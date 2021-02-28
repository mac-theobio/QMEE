---
title: "Minimal reproducible examples"
---

When you ask a question we (JD and/or BB) will often say "Can you send me a (minimal) **reproducible** example?" (these are sometimes called "reprexes" or abbreviated MWE (minimal working example) or MRE (ditto, reproducible)).

* **Reproducible** means something we can run for ourselves to replicate your problem on our computers. *Sometimes* we can just look at your code and see what's wrong, but most of the time we can't. In particular:
   * you should be able to run your code in a **clean R session** (RStudio: `Session > Restart R`)  and see the same problem. 
        * make sure you don't encounter any errors before the location of your main problem (e.g. because of unloaded data or unloaded packages causes an error before that point)
		* please tell us *specifically* what error/warning/wrong answer you're getting[^1]
   * if you e-mail/post your code as *text* (i.e., cut and paste from your script file)
* **Minimal** means to do whatever you can to make your example *short*, to save us the trouble of digging through/running lots of code to find the problem.
* Some further resources.  
  
    Many of these resources emphasize creating **self-contained** MREs, i.e. not depending on external data files etc.. That's less important for this course, where JD/BB have access to your Github repository. You can tell us e.g. "my MRE is in file 'mre.R', it uses 'mydata.csv', everything is on my repository".  Self-contained MREs are better - they're generally shorter, and anyone in the course can try them out without access to your repo if you post them to the Teams channel - but not absolutely necessary for this course.
    - [R-specific Stack Overflow question about reproducible examples](https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example)
    - [General Stack Overflow page on MREs](https://stackoverflow.com/help/minimal-reproducible-example)
    - [presentation by Sharla Gelfand](https://make-a-reprex-please.netlify.app/#1)
    - the [reprex package](https://CRAN.R-project.org/package=reprex), an R package for creating reprexes ([web page](https://reprex.tidyverse.org/))
    - a **very old** (but famous) post on ["how to ask questions the smart way"](www.catb.org/~esr/faqs/smart-questions.html) (mostly more general about asking advice on technical forums)


[^1]: The `fortunes` R package is a compendium of R-related snark. If you like snark, read on.
<!-- apparently I need manual paragraphs <p> to keep this footnote together (ugh) -->
<p>
`fortunes::fortune("picketing")`
<p>
> The phrase "does not work" is not very helpful, it can mean quite a few things including:
<p>
> * Your computer exploded.
* No explosion, but smoke is pouring out the back and microsoft's "NoSmoke"
utility is not compatible with your power supply.
* The computer stopped working.
* The computer sits around on the couch all day eating chips and watching talk
shows.
* The computer has started picketing your house shouting catchy slogans and
demanding better working conditions and an increase in memory.
* Everything went dark and you cannot check the cables on the back of the
computer because the lights are off due to the power outage.
* R crashed, but the other programs are still working.
* R gave an error message and stopped processing your code after running for a
while.
* R gave an error message without running any of your code (and is waiting for
your next command).
* R is still running your code and the time has exceeded your patience so you
think it has hung.
* R completed and returned a result, but also gave warnings.
* R completed your command, but gave an incorrect answer.
* R completed your command but the answer is different from what you expect
(but is correct according to the documentation).
<p>
> There are probably others. Running your code I think the answer is the last one.
<p>
> Greg Snow, R-help (April 2012)
