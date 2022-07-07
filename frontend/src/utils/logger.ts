/* eslint-disable no-console */

const isProduction = process.env.NODE_ENV === 'production'

//ssf: start stack function
export const $$log = (...args: any) => {
  if (!isProduction) console.log(...args)
}

export const $$info = (...args: any) => {
  if (!isProduction) console.info(...args)
}

export const $$warn = (...args: any) => {
  if (!isProduction) console.log(...args)
}

export const $$debug = (...args: any) => {
  if (!isProduction) console.debug(...args)
}

export const $$error = (...args: any) => {
  if (!isProduction) console.error(...args)
}

export const $$trace = (...args: any) => {
  if (!isProduction) console.trace(...args)
}

export const $$table = (args: any) => {
  if (!isProduction) console.table && console.table(args)
}

export function printTrace(ssf: any, log?: any) {
  if (!isProduction) return new LogTrace(ssf, log)
}

class LogTrace extends Error {
  constructor(ssf: any, log?: any, message?: string) {
    super(message || '')
    this.name = 'Error/Trace logs'
    // this.message = message || ''

    if (Error.captureStackTrace) {
      Error.captureStackTrace(this, ssf)
    } else {
      try {
        throw new Error()
      } catch (e: any) {
        this.stack = e.stack
      }
    }

    if(log != null) {
      log(this.stack)
    } else {
      console.log(this.stack)
    }
  }
}

export function $log(...params: any) {
  $$log(...params)
  printTrace($log, $$log)
}

export function $info(...params: any) {
  $$info(...params)
  printTrace($info, $$info)
}

export function $warn(...params: any) {
  $$warn(...params)
  printTrace($warn, $$warn)
}

export function $debug(...params: any) {
  $$debug(...params)
  printTrace($debug, $$debug)
}

export function $error(...params: any) {
  $$error(...params)
  printTrace($error, $$info)
}

export function $table(params: any) {
  $$table(params)
  printTrace($table, $$info)
}

export function $trace(...params: any) {
  $$debug(...params)
  $$trace(params)
}

export const $ssfLog = (ssf: any, ...params: any) => {
  $$log(...params)
  printTrace(ssf, $$log)
}

export const $ssfInfo = (ssf: any, ...params: any) => {
  $$info(...params)
  printTrace(ssf, $$info)
}

export const $ssfWarn = (ssf: any, ...params: any) => {
  $$warn(...params)
  printTrace(ssf, $$warn)
}

export const $ssfDebug = (ssf: any, ...params: any) => {
  $$debug(...params)
  printTrace(ssf, $$debug)
}

export const $ssfError = (ssf: any, ...params: any) => {
  $$error(...params)
  printTrace(ssf, $$info)
}

export const $ssfTable = (ssf: any, params: any) => {
  $$table(params)
  printTrace(ssf, $$info)
}

// new AssertionError('test message', { key: 'test', key2: 'bbbb' }, exports.log)
// function AssertionError(message, _props, ssf) {
//   var props = _props || {}
//
//   // Default values
//   this.name = 'Error/Info logs'
//   this.message = message || ''
//   this.showDiff = false
//
//   // Copy from properties
//   for (var key in props) {
//     this[key] = props[key]
//   }
//
//   // Here is what is relevant for us:
//   // If a start stack function was provided we capture the current stack trace and pass
//   // it to the `captureStackTrace` function so we can remove frames that come after it
//   ssf = ssf || arguments.callee
//   if (ssf && Error.captureStackTrace) {
//     Error.captureStackTrace(this, ssf)
//   } else {
//     // If no start stack function was provided we just use the original stack property
//     try {
//       throw new Error()
//     } catch (e) {
//       this.stack = e.stack
//     }
//   }
// }
