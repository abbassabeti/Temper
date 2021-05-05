# Temper-Test

This is a take-home challenge written by Abbas SabetiNezhad. To Find out more, read on.


![screenshot1](https://github.com/abbassabeti/Temper/blob/images/images/SCR01.PNG " ") ![screenshot2](https://github.com/abbassabeti/Temper/blob/images/images/SCR02.PNG " ") 
![screenshot3](https://github.com/abbassabeti/Temper/blob/images/images/SCR03.PNG " ")

## Depedencies

This App uses:

- [RxSwift](https://github.com/ReactiveX/RxSwift), [RxCocoa](https://github.com/ReactiveX/RxSwift), [RxRelay](https://github.com/JakeWharton/RxRelay): for communicating among Services, Coordinators, ViewModels and ViewControllers

- [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources): An Rx wrapper for UITableView and UICollectionView DataSource and Delegate, including facilities for Differentiable Data Source for optimizing TableView rendering.

- [RxGesture](https://github.com/RxSwiftCommunity/RxGesture) : a concise way of connecting gestures to Rx Elements

- [Moya](https://github.com/Moya/Moya) : a cleaner approach on defining your network requests

- [Kingfisher](https://github.com/onevcat/Kingfisher) : for loading images from urls

- [SnapKit](https://github.com/SnapKit/SnapKit) : a clean way of defining constraints in your code

- [CodableWrappers](https://github.com/GottaGetSwifty/CodableWrappers) : an amazing way of cleaning your model definitions using property wrappers for encode/decode data
        
To find out more about how to run the app, see Installation instructions below.

## Installation

To run the app, you need to clone it and then, use below command in the root folder of project

```ruby
pod install
```

And Finally, run the app. As it can be seen from the above screenshots, there is a single tableview with support for pull-to-refresh and Diffable dataSource in the app.

I also have written some UnitTests for the logic parts of the app which is available under a sub project, named TemperTests in the main project.

## Author

Abbas SabetiNezhad, abbassabetinejad@gmail.com

## License

Temper is available under the Temper license.

