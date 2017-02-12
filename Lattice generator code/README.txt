README file
-----------

This is the README file describing the matlab code used to generate random 12 by 12 cell lattices. 

Usage
-----

From a matlab prompt, this directory type:

generateLattices 


Description
----------

This will generate two sets of 20 random 12 by 12 cell lattices in a directory
called 'lattices' which the program will attempt to create. 
In the first set of lattices, each cell has exactly six neighbors. They are
saved in files named 'rlat12X12_nn.mat', where nn is the lattice index. 
The second set of lattices are save in files named rlat12X12_nn.mat and here
cell may have more or less than six neighbors. 

Graphical representations of the lattice are saved in eps files with
corresponding names.  

The lattices have a torus shape (top is connected to bottom, left is connected to right).
More information on how the lattices are generated is provided in the supplement of the
Dev. Cell paper mentioned below. 

Data
-------------
The mat file contain the following variables

g: the structure summarizing the lattice.
weights: weight matrix for all cells
perim: perimeter of each cell
area: area of each cell


Credit
------

This code was written by M. Hersch using earlier code from K. Chiou. 
If reusing this code for research puposes, please cite Shaya, Binshtok et al. (2017) Dev. Cell. 
