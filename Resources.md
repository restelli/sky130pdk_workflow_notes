# Some resources

## Magic labs

[Berkley lab 1](https://inst.eecs.berkeley.edu/~cs250/fa20/labs/lab1/)

[Guide to Magic](https://lootr5858.wordpress.com/2020/10/06/magic-vlsi-skywater-pdk-local-installation-guide/)

[Extensive Magic documentation and tutorials](http://opencircuitdesign.com/magic/archive/papers/)

## Videos
[Make a hierarchical design with Magic for Skywater sky130 process](https://www.youtube.com/watch?v=RPppaGdjbj0)

[Terminology and details about the overall process: remoticon 2020](https://www.youtube.com/watch?v=lq2BpWwcyQM)

### Magic Classes by Efabless
[Tutorial 1](https://www.youtube.com/watch?v=ORw5OaY33A4): Basics

[Tutorial 2](https://www.youtube.com/watch?v=NUahmUtY814): Cells

[Tutorial 3](https://www.youtube.com/watch?v=OKWM1D0_fPI): Parametrization

[Whole Efabless channel with all videos](https://www.youtube.com/c/efabless_channel/videos): they inlude system design simulation etc...

### Other not watched classes about magic
[To be tested](https://www.youtube.com/watch?v=SK6OysA97wQ)

[Inverter from scratch (not using wizard)](https://www.youtube.com/watch?v=RPppaGdjbj0)

## Cryogenic tests

[Mehdi Saligane pubblications](https://scholar.google.com/citations?hl=en&user=u1UAQ2QAAAAJ&view_op=list_works&sortby=pubdate)(University of Michigan) contains a great amount of details about Google Open source PDK project

The project for characterizing mos at cryogenic temperatures is here

```bash
git clone https://github.com/msaligane/openfasoc_cryo_caravel
cd openfasoc_cryo_caravel/gds
magic -T sky130A user_analog_project_wrapper.gds
```


