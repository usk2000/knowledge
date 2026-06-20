# Bitrise Build API : Lambda -> Bitrise


[Triggering and aborting builds - Bitrise Docs](https://devcenter.bitrise.io/en/api/triggering-and-aborting-builds.html#triggering-and-aborting-builds)

[Bitrise + AWS CodeCommit](inkdrop://note/pd5ycy7Es)

必要なもの
- branch
- branch_dest (PRの場合) 
- pull_request_id: $BITRISE_PULL_REQUESTにマップされる
- commit_dest: 

[Available environment variables - Bitrise Docs](https://devcenter.bitrise.io/en/references/available-environment-variables.html#available-environment-variables)

POST request送る方法
[javascript - AWS Lambda HTTP POST Request (Node.js) - Stack Overflow](https://stackoverflow.com/questions/47404325/aws-lambda-http-post-request-node-js)
