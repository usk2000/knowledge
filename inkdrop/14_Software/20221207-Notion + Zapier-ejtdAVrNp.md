# Notion + Zapier


Database Itemが作成できない？
https://help.zapier.com/hc/en-us/articles/8496040151821#my-databases-are-not-listed-in-the-dropdown-menu-0-0

> path failed validation: path.database_id should be a valid uuid, instead was `"中島聡 mag2 0001323030"`.
> 

https://qiita.com/www_y118/items/7c13cda8100e403fea48
https://community.zapier.com/code-webhooks-52/how-to-use-zapier-formatter-to-generate-guid-13582

UUIDセットした後

> The app returned "Could not find database with ID: f5d29a54-5881-4101-ada6-444106964719. Make sure the relevant pages and databases are shared with your integration.".
> 

https://mamunga.com/notion-api-database-not-found

> body failed validation: body.children[28].paragraph.children[0].code.language should be defined, instead was `undefined`.
> 

GMailのSnippetではできた。

Markdownではなく、blockが必要そう
https://www.reddit.com/r/Notion/comments/q7680q/how_do_i_add_markdown_using_notion_api/
https://developers.notion.com/docs/working-with-page-content

blockに変更することができないので、諦める。
それか、markdownからblockに変更するコードを書く

Markdown to Notion
https://github.com/tryfabric/martian
これを外部サービス化すれば良いかな。そうすればRest APIで対応できそう。





