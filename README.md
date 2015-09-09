# lita-openweathermap

[![Build Status](https://travis-ci.org/aleks/lita-openweathermap.png?branch=master)](https://travis-ci.org/aleks/lita-openweathermap)

A Lita Handler for OpenWeatherMap Data. (http://openweathermap.org/)

## Installation

Add lita-openweathermap to your Lita instance's Gemfile:

``` ruby
gem "lita-openweathermap"
```

## Configuration

Add your prefered metric to your Lita config (Default: 'metric'):

``` ruby
Lita.configure do |config|
  config.handlers.openweathermap.metric = "metric" # 'metric' or 'imperial'
end
```

## Usage

```
Lita: weather berlin, germany
```

## License

[MIT](http://opensource.org/licenses/MIT)

