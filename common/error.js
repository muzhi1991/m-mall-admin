// 参考 https://stackoverflow.com/a/43595019

// eroor
// class CustomError extends Error {
//     constructor(message) {
//       super(message);
//       this.name = 'CustomError';
//     }
//   }


// pure es5
// function CustomError(message, fileName, lineNumber) {
//   var instance = new Error(message, fileName, lineNumber);
//   Object.setPrototypeOf(instance, Object.getPrototypeOf(this));
//   return instance;
// }
// CustomError.prototype = Object.create(Error.prototype, {
//   constructor: {
//     value: Error,
//     enumerable: false,
//     writable: true,
//     configurable: true
//   }
// });
// if (Object.setPrototypeOf){
//     Object.setPrototypeOf(CustomError, Error);
// } else {
//     CustomError.__proto__ = Error;
// }

// new CustomError(msg)
// new CustomError(code,meg)
function CustomError(...args) {
  var instance = null
  if (args.length == 1) {
    instance = Reflect.construct(Error, args);
    instance.errorCode = undefined
  } else if (args.length = 2) {
    instance = Reflect.construct(Error, [args[1],]);
    instance.errorCode = args[0]
  }
  Reflect.setPrototypeOf(instance, Reflect.getPrototypeOf(this));
  return instance;
}
CustomError.prototype = Object.create(Error.prototype, {
  constructor: {
    value: Error,
    enumerable: false,
    writable: true,
    configurable: true
  }
});
Reflect.setPrototypeOf(CustomError, Error);

export default CustomError

