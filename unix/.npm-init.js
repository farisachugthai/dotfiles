#!/usr/bin/env node
let fs = require('fs')
let repl = require('repl')
let readline = require('readline')
let path = require('path')
let process = require('process')
let vm = require('vm')

let term = console.Console(process.stdout)

// https://nodejs.org/api/repl.html#repl_recoverable_errors
// As a user is typing input into the REPL prompt, pressing the <enter> key
// will send the current line of input to the eval function. In order to support
// multi-line input, the eval function can return an instance of repl.Recoverable
// to the provided callback function:


function myEval(cmd, context, filename, callback) {
  let result;
  try {
    result = vm.runInThisContext(cmd);
  } catch (e) {
    if (isRecoverableError(e)) {
      return callback(new repl.Recoverable(e));
    }
  }
  callback(null, result);
}

function isRecoverableError(error) {
  if (error.name === 'SyntaxError') {
    return /^(Unexpected end of input|Unexpected token)/.test(error.message);
  }
  return false;
}
