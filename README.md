<p align="center">
  <img src="http://szarkowicz.info/github/pesel-swift/banner_medium.png" alt="PeselSwift logo ">
</p>

![Build passing](https://img.shields.io/badge/build-passing-brightgreen.svg?style=flat)
![Swift 3.0](https://img.shields.io/badge/in-swift%204.0-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


# PeselSwift
Easy and lightweight library for Pesel (Polish National Identification Number) validation.

## How to use
You can add framework to your project manually, or ...

add framework using Carthage:

```
github "lukszar/PeselSwift"
```

## Examples
Below look at examples you can use in your app.

### Validate Pesel
```
  let pesel = Pesel(pesel: "XXXXXXXXXXX")
  let result = pesel.validate()
        
  switch result {
    
    case .success:
      print("success")
            
    case .error(let error):
      print("failure with error: \(error)")
  }
```

or 

```
  let result = Pesel.validate(pesel: "XXXXXXXXXXX")
        
  switch result {
    
    case .success:
      print("success")
            
    case .error(let error):
      print("failure with error: \(error)")
  }
```


### Get birth date from pesel
```
let pesel = Pesel(pesel: "XXXXXXXXXXX")
let date = pesel.birthdate()
print(date)
```

## App demo

Download demo app to see examples of usage.

<img src="http://szarkowicz.info/github/pesel-swift/screenshot.png" alt="Screenshot from application">
