# demo wordpress

```
git cycloid-stack-test
                                                         git step-by-step (stack-aws)               Instance EC2
+--------------------+
|                    |                                   +---------------------+                   +---------------------------------------------+
|  Terraform.sample  |                                   |                     |                   |                                             |
|  .forms            |    give Git code url/branch       |  Terraform module   |                   |   Docker run: step-by-step-nginx            |
|  pipelines +-------------------------------------------+                     |                   |   +--------------------------------------+  |
|                    |                                   |                     |                   |   |                                      |  |
+--------------------+                                   |                     |                   |   |        Git clone step-by-step (code) |  |
                                                         |                     +-------------------+   |                                      |  |
                                                         |                     |                   |   |                                      |  |
                                                         |                     |                   |   +--------------------------------------+  |
                       cycloid-stack-test-config+--------+                     |                   |                                             |
                                                         |                     |                   |                                             |
                                                         |                     |                   |                                             |
                                                         |                     |                   |                                             |
                                                         +---------------------+                   |                                             |
                                                                                                   +---------------------------------------------+
```

# aws-gitlab

![image](https://user-images.githubusercontent.com/1426698/110343171-7f719a80-802c-11eb-8d37-4dce34c85ad4.png)

## Gitlab account

user/password stored in `secret/cycloid/gitlab/cycloidmachine`


If needed to re-setup gitlab project demo

Create new project
```
Run CI/CD for external repository
Repo by Url: https://github.com/cycloidio/demo-gitlab-wordpress
Project name: wordpress-demo
```

Add cycloid docker credential. Go on `settings/ci_cd`
```
Key: CI_REGISTRY_PASSWORD
Protected: false
Masked: true
Value: (vault read secret/cycloid/dockerhub/cycloidmachine)

Key: CI_REGISTRY_USER
Protected: false
Masked: false
Value: cycloidmachine
```

## Create a gitlab-runner for the project

/!\ we currently use the free gitlab worker. The stack not realeased yet (only a draft) /!\

Get the `registration token`
  * Go on `settings/ci_cd/Runners`, click on `Expand` and copy the `registration token`

Create a `custom` credential on cycloid

```
Name: gitlab_token_wordpress
Type: custom
Key=Value: value=<paste the token>
```

Using the cycloid `stack-gitlab-runner` create the runner
