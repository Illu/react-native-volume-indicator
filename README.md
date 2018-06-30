<h1 align="center">
  <img src="./logo.png"/><br>
  react-native-volume-indicator
</h1>

![platforms](https://img.shields.io/badge/platform-iOS-brightgreen.svg?style=flat&colorB=191A17)
[![MIT License][license-badge]][license-url]
[![npm](https://img.shields.io/npm/v/react-native-volume-indicator.svg?style=flat
)](https://www.npmjs.com/package/react-native-volume-indicator)

## tl;dr

Replaces the default iOS volume popup by a less-obtrusive indicator.
Includes helpers to get access and subscribe to your app's audio volume.

## Getting started

`$ npm install react-native-volume-indicator --save`

## Installation

>⚠️ Only iOS is supported at the moment.

### Mostly automatic installation

`$ react-native link react-native-volume-indicator`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` and select `Add Files to [your project's name]`
2. Go to `node_modules/react-native-volume-indicator` and add `RNVolumeIndicator.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNVolumeIndicator.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project

## Usage

>⚠️ Please note that you'll only be able to get the actual volume
using a physical device.

### VolumeIndicator

Component that displays a volume indicator.
By default, it looks like a blue slider that fills up 
from left to right depending on the current volume.

##### Exemple
```javascript
import VolumeIndicator from 'react-native-volume-indicator';

class App extends React.Component {
  render() {
    <VolumeIndicator />
  };
}
```

### getVolume()

Call it whenever you need to get the volume of your app's audio.

##### Exemple
```javascript
import {getVolume} from 'react-native-volume-indicator';

class App extends React.Component {
  
  _getVolume() {
    getVolume().then(volume => {
      // ...
    })
  }
}
```


### listenToVolumeChange(callback) / stopListeningToVolumeChange()

Use `listenToVolumeChange` when you want to start listening to volume change.
Don't forget to remove the listener by calling `stopListeningToVolumeChange()`.

Allows you to create your own volume indicator easily.

##### Exemple
```javascript
import {listenToVolumeChange, stopListeningToVolumeChange} from 'react-native-volume-indicator';

class App extends React.Component {
  
  componentDidMount(){
    listenToVolumeChange(this._onVolumeChange);
  }
  
  componentWillUnmount(){
    stopListeningToVolumeChange();
  }
  
  _onVolumeChange = (volume) => {
    // ...
  }
}
```
  
## Licence ##
MIT License

See [LICENSE](LICENSE)

[license-badge]: http://img.shields.io/badge/license-MIT-blue.svg?style=flat
[license-url]: LICENSE