---
source: 30 - Other Services\004 CloudFormation - Service Role_zh.srt
---

Stephane：所以这里有一件事你需要知道关于CloudFormation和安全性｡

因此CloudFormation可以使用服务角色｡ 

它们是什么？

它们是您创建的iam角色, 专用于CloudFormation,

允许CloudFormation代表您实际创建更新和删除堆栈资源｡

因此, 如果您想让用户能够实际创建､

更新和删除堆栈资源,

但他们没有直接使用资源的权限,

那么您可以使用服务角色｡

例如, 我们定义了一个模板和我们自己的iam权限,

作为用户在CloudFormation上执行操作｡

我们有我的通行证｡ 

我们还创建了一个服务角色, 我们将致力于CloudFormation｡

而这个服务角色拥有S3星桶的权限,

比如创建､

更新和删除一个桶｡

因此, CloudFormation将能够创建这个S3存储桶,

这要归功于它的服务角色, 因为用户能够将该角色传递给CloudFormation｡

因此, 安全性的用例是, 如果您希望实现最小特权原则,

并且不希望为用户提供创建堆栈资源的所有权限, 而只是调用CloudFormation上的服务角色的权限｡

为此, 请记住用户必须具有名为iam

PassRole的权限, 这是为AWS中的特定服务提供角色所必需的权限｡

让我来给你展示一个使用CloudFormation的iam角色的例子｡

如果您转到iam, 然后转到iam中的roles部分,

我们将为AWS服务创建一个角色, 该服务是CloudFormation｡

接下来是权限策略, 我将为S3提供完全访问权限,

以便为Amazon S3提供专用角色,

这只是一个示例｡

单击下一步,

我将其称为具有S3功能的CFN DemoRole｡

因此, 这个角色允许CloudFormation使用Amazon

S3做任何事情｡

所以这个角色就被创造出来了｡ 

现在, 如果我去CloudFormation并创建一个堆栈,

我将只使用我现有的模板之一｡

我不需要什么特别的东西｡ 

我们不会一直这样下去｡ 

所以我称之为DemoRole｡ 

点击下一步｡ 

正如你在这里看到的,

在权限中有一个iam角色｡

这是可选的｡ 

所以如果我不指定, 那么iam角色将使用我自己的个人权限｡

但是, 如果我想指定一个iam角色,

我可以查看具有S3功能的CFN的DemoRole｡

这个角色将用于所有堆栈操作｡

所以这意味着角色现在不会使用我自己的个人权限,

而是这个, 因为这个角色只使用Amazon

S3权限, 那么实际上我的堆栈将失败, 因为我的堆栈实际上正在创建EC2实例｡

但如果您想为CloudFormation使用iam角色,

则实际上是在这里定义权限的｡

就是这样｡ 

我希望你们会喜欢, 下次课再见.
