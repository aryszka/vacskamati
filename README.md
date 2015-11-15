# vacskamati

A truly trash style distributed note taking tool.


### Dev Notes

- the template processor is a dangerously simplistic solution. It works, but one important restriction is that
  only one include is allowed per line.
- currently only `make debug` is working, because uglifyjs doesn't uglify es6, and test-interop.js is in es6.
  test-interop.js is a temporary file, and will be gone soon.
 

### Dev Next Steps:

- find an editor
- integrate service workers with elm
