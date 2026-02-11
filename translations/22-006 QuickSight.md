---
source: 22 - Data & Analytics\006 QuickSight_zh.srt
---

讲师：现在我们来谈谈Amazon QuickSight｡ 

Amazon QuickSight是一个由机器驱动的无服务器商业智能服务,

当你听到商业智能时, 这意味着你将创建交互式仪表盘｡

这就是QuickSight的样子,

您可以创建仪表板, 这些仪表板连接到您拥有的数据源,

因此您可以创建这些漂亮的视觉效果｡

它速度快, 可自动扩展,

您可以将其嵌入网站,

并按会话定价｡

QuickSight的使用案例将围绕业务分析､

构建可视化､ 以可视化方式执行即席分析,

以使用数据获得业务洞察｡

因此, 您可以连接到许多数据源, 如RDS､

Aurora､ Athena､

Redshift､ S3等, 我们将在下一张幻灯片中看到｡

现在有一个叫做SPICE引擎的东西,

你需要记住它, 它是一个内存中的计算引擎, 只有当你把数据直接导入Amazon

QuickSight时, 它才能工作｡

如果Amazon QuickSight连接到另一个数据库,

则无法使用｡

最后, QuickSight有一些非常好的用户级特性,

因此可以在Amazon

QuickSight的企业版中设置列级安全性CLS, 以防止在某些用户没有足够的访问权限时为他们显示某些列｡

那么, QuickSight与什么集成？

您可以将它与AWS的许多数据源集成, 例如, RDS数据库､

Aurora或Redshift（一种出色的数据仓库服务）､

Athena（用于在Amazon S3上执行即席查询）､ Amazon S3（用于实际导入数据）､ OpenSearch或Timestream（用于以优化的方式可视化时间流数据）｡

您还可以与第三方数据源集成, 这些数据源是软件即服务,

并由QuickSight支持, 完整列表位于QuickSight网站上, 但其中一些包括Salesforce和Jira｡

您还可以与第三方数据库（如Teradata）集成,

或者与内部使用JDBC协议的内部部署数据库集成｡

正如我所说的, 您可以将数据源直接导入QuickSight,

例如Excel文件､ CSV文件､ JSON文档､

TSV或用于日志格式的EFS CLF格式｡

如果将这些数据源导入到Amazon

QuickSight中,

您就可以利用SPICE引擎以非常非常快的方式执行内存计算｡

这是集成的部分, 在考试中,

你会经常看到使用QuickSight和Athena或QuickSight和Redshift,

但这些都有可能被看到｡

现在, QuickSight中有两样东西：仪表盘和分析｡

因此, 在QuickSight中,

您实际上拥有标准版中提供的用户和企业版中提供的用户组, 而这些用户和用户组仅存在于QuickSight服务中,

因此它们不等同于IAM用户｡

IAM用户仅用于管理｡ 

因此, 您可以在QuickSight中定义这些用户和组,

然后创建一个仪表板｡

仪表板是分析的只读快照,

因此可以共享, 它将保留分析的配置,

因此您在分析中设置的任何筛选器､ 参数､ 控件和排序选项都将被保留, 并将成为一个仪表板｡

因此, 分析更加完整,

但您可以与特定用户或组共享分析或仪表板,

为此, 您必须首先发布仪表板等｡

然后, 如果用户有权访问仪表板,

他们还可以看到底层数据｡

因此, 在QuickSight中,

您可以创建分析或仪表板, 然后将其与指定的用户和组共享｡

就是这样, 您已经了解了有关QuickSight考试的所有信息｡

我希望你们喜欢,

下节课再见｡
