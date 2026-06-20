# BitriseでCodeCoverageも出力する


[Xcode 11 test Coverage report - Question & Answer - Bitrise Discussions](https://discuss.bitrise.io/t/xcode-11-test-coverage-report/11455)
[Oversee code coverage reports with the Codecov Verified Step | Bitrise](https://blog.bitrise.io/post/oversee-code-coverage-reports-with-the-codecov-verified-step)

xcovが使えそう

```bash
#!/usr/bin/env bash
# debug log
set -x

gem install xcov
xcov -f $BITRISE_XCRESULT_PATH -o reports
zip -r $BITRISE_DEPLOY_DIR/xcov_report.zip reports/*
```
