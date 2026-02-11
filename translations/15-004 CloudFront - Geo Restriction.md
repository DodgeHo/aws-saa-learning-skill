---
source: 15 - CloudFront & AWS Global Accelerator\004 CloudFront - Geo Restriction_zh.srt
---

讲师：关于CloudFront

Geo Restriction的简短讲座｡

因此, 您可以根据他们试图访问发行版的国家/地区来限制谁可以访问您的发行版｡

因此, 您可以设置一个allowlist来定义已批准国家/地区的列表,

或者您可以设置一个blocklist来设置被禁止国家/地区的列表｡

现在, 通过使用第三方Geo-IP数据库将用户的IP与其所属的国家进行匹配来确定国家｡

因此, 使用地理限制的用例将是版权法来控制对内容的访问｡

因此, 要打开地理限制, 请转到“安全”下,

然后在这里您将找到CloudFront地理限制,

还有国家/地区｡

然后你点击编辑｡ 

所以它有点隐藏, 但在那里你可以有一个allowlist或blocklist｡

例如, 我们可以设置一个allowlist,

并枚举始终允许的国家/地区, 其余的将被CloudFront阻止｡

因此, 我们在这里说, 印度和美国是允许在我们的CloudFront分布｡

如果我们对此满意, 我们保存更改｡ 

正如你所看到的, 现在它的类型是allowlist,

国家列在这里｡

就是这样｡ 

所以我希望你们喜欢,

我们下次课再见｡
