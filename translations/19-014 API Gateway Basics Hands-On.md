---
source: 19 - Serverless Overviews from a Solution Architect Perspective\014 API Gateway Basics Hands-On_zh.srt
---

教师：让我们打开API网关, 我们进入API网关控制台｡

正如你在这里看到的,

我可以选择一个API类型｡

所以我们有HTTP, API, 我们有WebSocket

API, REST API, 它们是公共的或私有的,

因此, 我们现在只处理REST API｡

所以我们可以通过点击这个来尝试新的控制台,

这将很快成为默认值｡

所以请确保有这个｡ 

然后你选择REST API, 然后你构建它｡ 

所以当你构建一个API, 一个REST API时,

你有几个选择｡

你可以创建一个新的API, 你可以从一个开放的API定义文件中导入一个｡

这里说的是文件和导入,

API是为你创建的｡

您可以克隆现有的API,

也可以从示例API开始｡

对于我们来说, 我们将从一个新的API开始,

名称将是MyFirstAPI｡

现在, 如您所见, 对于API端点类型,

我们有三个选项｡

我们有区域, 边缘优化或私人｡ 

因此, 区域将部署在一个区域｡ 

边缘优化将部署在许多不同的地区,

但它将部署在边缘｡
**学习目标**
- 掌握在 API Gateway 控制台创建 REST API、方法并将其与 Lambda 集成的基本流程
- 了解部署阶段、测试与如何把 API 部署为对外可访问的 URL

**重点速览**
- 在 API Gateway 中创建 API 后，可为资源路径添加方法（GET/POST 等），并选择集成类型（Lambda、HTTP、Mock、AWS Service、VPC Link）
- 常用集成为 Lambda Proxy，API Gateway 会将请求完整传入 Lambda 并解析 Lambda 返回的响应
- 部署时需创建阶段（如 dev/prod），默认超时为 29 秒，且需为 API Gateway 授权调用 Lambda 的权限

**详细内容**
实操要点：
1. 在控制台创建 REST API（选择区域/边缘优化/私有端点类型）。
2. 为资源创建方法（例如 GET），选择集成类型为 Lambda，并启用 Lambda Proxy 集成以透传请求。API Gateway 会自动为该 API 授予调用对应 Lambda 的权限（基于资源策略）。
3. 在 Lambda 中编写并部署代码，使用测试事件验证，再回到 API Gateway 测试方法；查看 CloudWatch 日志以调试传入的事件与函数执行结果。
4. 部署 API 时创建阶段（如 dev），获取调用 URL 并在浏览器或客户端调用；注意 API Gateway 的默认超时（29 秒）可能短于 Lambda 超时，需要协调。

**自测问题**
- API Gateway 与 Lambda 的常见集成方式有哪些？什么是 Lambda Proxy 集成？
- 默认的 API Gateway 超时是多少？如何将 API 部署为对外可用？
- 创建私有 API 时应使用哪种端点类型？

