---
source: 22 - Data & Analytics\004 OpenSearch (ex ElasticSearch)_zh.srt
---

现在, 让我们来谈谈Amazon OpenSearch服务｡ 

Amazon OpenSearch是您之前可能听说过的Amazon

ElasticSearch的继承者｡

因此, 名称的更改是由于一些许可问题｡ 

因此, 在DynamoDB中, 只是为了进行比较,

您只能通过主键或数据库上是否有索引来查询数据｡

但是使用OpenSearch,

正如其名称所示, 您实际上可以搜索任何字段,

甚至是部分匹配｡

因此, 使用OpenSearch为应用程序提供搜索是非常常见的｡

因此, 您可以使用OpenSearch作为对另一个数据库的补充｡

因此, OpenSearch可以用于搜索,

但正如其名称所示, 您也可以在OpenSearch之上进行分析查询｡

因此, 您有两种模式来配置OpenSearch集群｡ 

您可以使用托管集群选项,

然后为您提供实际的物理实例, 您将看到它们｡

或者你可以走无服务器路线,

拥有一个无服务器集群,

从扩展到操作的一切都由AWS处理｡

OpenSearch有自己的查询语言,

它本身并不支持SQL, 但你可以通过插件来启用SQL兼容性｡

因此, 您可以从不同的地方摄取数据, 例如Kinesis

Data Firehose､ IoT､ CloudWatch Logs或任何自定义构建的应用程序｡

通过与Cognito､

IAM的集成, 您可以获得静态加密和动态加密｡

正如我所说的, 你可以在OpenSearch服务之上进行分析,

所以你可以使用OpenSearch仪表板在你的OpenSearch数据之上创建可视化｡

这里有一些使用OpenSearch的常见模式｡ 

因此, 您将拥有DynamoDB, 它将包含您的数据｡ 

这是用户插入､ 删除和更新数据的位置｡

然后你在DynamoDB流中发送所有流, 然后由Lambda函数拾取｡

Lambda Function将实时将数据插入Amazon

OpenSearch｡

通过这个过程,

您的应用程序现在能够搜索特定的项目｡

例如, 使用项目名称执行部分搜索, 然后从中查找项目ID｡

一旦获得了项目ID, 它将调用DynamoDB从DynamoDB表中实际检索完整的项目｡

这是OpenSearch提供搜索功能的常见模式,

而您的主要数据源仍然是DynamoDB表｡

还有其他方法可以将CloudWatch日志摄取到OpenSearch中｡

因此, 第一个是使用所谓的CloudWatch日志订阅过滤器,

将数据实时发送到由AWS管理的Lambda

Function｡

然后Lambda函数将所有数据实时发送到Amazon

OpenSearch｡

或者, 您也可以使用CloudWatch日志,

然后使用订阅过滤器｡

但这一次Kinesis Data Firehose可以从订阅过滤器中读取它｡

然后接近实时, 因为这是数据消防管,

数据将被插入到Amazon

OpenSearch中｡

其他模式在Kinesis上,

因此要将Kinesis数据流发送到Amazon OpenSearch, 您有两种策略｡

第一个是使用Kinesis Data Firehose｡ 

这是一种近乎实时的服务｡ 

您可以选择使用Lambda函数进行一些数据转换,

然后将数据发送到Amazon OpenSearch｡

或者, 您可以再次使用Kinesis数据流,

但这一次, 您将创建一个Lambda函数来实时读取数据流｡

然后, 您可以编写自定义代码,

让Lambda函数实时写入Amazon OpenSearch｡

所有这些模式都是有效的,

现在您已经知道了使用Amazon OpenSearch的所有可能的架构｡

这节课就到这里｡ 

我希望你们喜欢, 我们下次课再见｡
