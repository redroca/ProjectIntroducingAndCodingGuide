## 目录

[TOC]

## 前言

​	随着公司团队及业务的扩大和增长，为了更好的适应团队内部的项目开发及维护，以及后续新进人员的培训，现对已经做过的公司项目进行整理，将核心框架及规范进行单独抽出模块进行管理以方便后续开发使用和维护。以下会对项目的文件结构，项目结构，核心库（M4CoreFoundation）等进行详细的说明。

## iOS 工程文件结构（以ExampleProject项目为例）

![1](http://otdtbznd1.bkt.clouddn.com/1.png)

#### 一级目录

需要注意的是Libs文件夹，其存放的是第三方库。一般存放非cocoapods导入的库，如QQ、微信的SDK。

#### 二级目录

主要以ExampleProject文件下的为主，该文件包含整个工程的核心文件。所有项目的Controller、View、Model、配置文件都存放在此处。Common、Controller、Model、View、Resource、RESTfulAPI、VendorAPI等文件夹会在（二、iOS 项目结构）做详细的说明。

#### 三级目录

以Common文件夹为例，根据每个项目的需求，存放跟项目密切相关的文件。该目录下包括.h文件、Additions、Categories、Components、SubClasses以及Utility文件夹。同样这些会在（二、iOS 项目结构）做详细说明。



## iOS 项目结构

 ![2](http://otdtbznd1.bkt.clouddn.com/2.png)

​	整个项目分为两大块，ExampleProject和Pods文件夹。ExampleProject文件夹是我们工程创建时生成的，Pods是第三方库管理工具生成的。下面对这两大块进行说明。

#### ExampleProject工程

我们主要看名为ExampleProject文件下所包含的内容，这是整个项目的核心内容。如下图

![3](http://otdtbznd1.bkt.clouddn.com/3.png)



##### Common

其内部结构如下图 	

![4](http://otdtbznd1.bkt.clouddn.com/4.png)

* CommonAppHeaders.h：存放项目中所用到类的头文件。


* AppConstants.h：使用#define自定义的一些常量都会放在此处。


* PodsHeaders.h：存放所有用pods管理的头文件。


* Additions文件夹：存放项目中附加的一些类。
  * CoreCache+App.h处理系统缓存。
  * CoreStore+App.h通过利用系统的NSUserDefault来存储一些基本数据类型数据。
  * UIColor+App.h声明并实现项目用到的所有颜色集合。
  * 如项目中用到不同的字体和大小，也可创建UIFont+App.h的Category来处理。


* Categories文件夹：存放项目中用到的Category，如果是一些通用的Category会集成在Pods中。


* SubClasses文件夹：用于存放一些子类


* Utility文件夹：用于存放所有的工具类，后期会整理一些通用的集成到现有的Pods中。


* Components文件夹：用于存放自定义的组件。比如自定义UIbutton，自定义AlertView等。
  
  ​

##### Controllers

如图，包含整个项目的所有Controllers，需根据具体项目结构创建不同Group，如Home、Second等。

注：在创建Controllers时，需在命名每个类时加上工程前缀。可根据需要继承相关的controller，简单的controller可继承BaseUIViewController，列表型的可继承BaseTableViewController，若带有刷新可继承BaseRefreshTableViewController等。

​	![5](http://otdtbznd1.bkt.clouddn.com/5.png)



##### View、Model同Controller类似。

注：创建自定义View时，大部分情况下建议使用xib处理，因此需要继承CoreDesignableXibUIView。

Model需要继承ModelBaseClass。



##### Resource

存放项目中的所有资源文件，包括图片、音频文件等。图片通过Asset Catalog进行管理。



##### RESTfulAPI：处理所有跟网络相关的请求操作，结构如下图。

​	![6](http://otdtbznd1.bkt.clouddn.com/6.png)

* BaseAPIURL.h：定义全局网络请求域名，包括LOCAL_DEVELOPMENT（本地）、TEST（测试）和PRODUCTION_RELEASE（生产），根据需要设置相应的环境。


* Calls、Logon、PatrolLogs、RecoveryPwd是根据业务需求自定义分组。每个group下都包含接口声明类和接口实现和处理类。如CallsAPIURL.h是接口声明类，CallsAPIRESTfulService是接口请求和处理类。
  
  ​

##### VendorAPI

此处存放对第三方库进行封装后的类。



##### Libs

用于存放第三方库（用于非cocoapods导入的库）。如下图

​	 ![7](http://otdtbznd1.bkt.clouddn.com/7.png)

libHeaders.h用于导入所有Libs中第三方的头文件。



##### Supporting Files

创建工程时自动创建的，一般我们会将除以上文件的其他文件放在这里。如plist、main.m等。如下图

​	 ![8](http://otdtbznd1.bkt.clouddn.com/8.png)

* CodeStyle.text：对代码规范及标注进行说明。



#### Pods工程

通过cocoapods管理第三方库，此处主要介绍公司内整理制作的M4CoreFoundation。

##### 集成方式

`pod 'M4CoreFoundation'`

注：M4CoreFoundation依赖MJRefresh、AFNetworking、YYImage、YYWebImage、YYCache、YYCategories、YYModel，因此不需要单独在Podfile集成。



## M4CoreFoundation库 

![Alt text](http://otdtbznd1.bkt.clouddn.com/9.png)

M4CoreFoundation主要按照上图进行分类，包括M4CoreFoundation.h、BaseClass、Category、Foundation、Macros、Networking、Notifications、SNS、UIKit、Utility、ViewControllers。

#### BaseClass：存放所有基类文件

#### Category：存放所有通用Category

#### Foundation：基于Foundation封装的缓存类、简单数据存储

#### Macros：定义的一些通用宏

#### Networking：基于AFNetworking封装网络请求库，包括HttpResponseCode等。

#### Notifications：用于封装系统内的通知提示。

#### SNS：用于快速分享

#### UIKit：对一些常用的控件二次封装处理

#### Utility：系统工具类

#### ViewControllers：存放所有基类controllers，一般开发中可以直接继承相应的controller即可

