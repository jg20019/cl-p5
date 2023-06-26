# cl-p5
### _John Gibson <jg20019@gmail.com>_

Cl-P5 is a Common Lisp wrapper around p5.js. Users create sketches by creating
setup and draw functions from Common Lisp. For ease of use, this project includes
the ability to create a server to view your sketches.

## QuickStart

Since this project is not in Quicklisp, you will need to download this repository to 
your local projects folder. Quickloading the project should pull down most of the 
depencies you need with the exception of p5.js which is loaded from a CDN.

```cl
CL-USER> (ql:quickload :cl-p5)
CL-USER> (in-package :cl-p5)
CL-P5> (setup (create-canvas 400 400)) ;; redefines setup
CL-P5> (draw (background 100)) ;; redefines draw
CL-P5> (start :port 4000) ;; starts the server. Visit localhost:4000 to view the sketch
```


## License

MIT License

Copyright (c) 2023 John Gibson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

