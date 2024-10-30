# README.md

> ## This is a stack README file displayed on stack details pages. Edit it to showcase your stack, tell people what can be done with it and how to used it.

## Stack blueprints READMEs

When using stack templates, the README file of the template will be copied over to the stacks generated.  
Like for other files of a template, it is possible to use the Go `text/template` templating inside the template `README.md` file. 
In order to not interfere with other templating systems, like Ansible, the delimiters for the template are not the standard ones but ` and `.
It will be compiled when users generate a stack from it.

Some variables are exposed and can be used in READMEs to generate dynamic content.

**Available variables**

| Name | Description |
|--|--|
| `.stack_usecase` | The key of the selected use case |
| `.stack_author` | The username of the user who creates the stack |
| `.stack_canonical` | The stack canonical filled in by the user |
| `.stack_path` | The path of the generated stack in the catalog repository |
| `.scs_canonical` | The canonical of the target catalog repository |
| `.scs_cred_path` | The path in Vault of the target catalog repository credential |
| `.scs_cred_type` | The type of the target catalog repository credential (`ssh` or `basic_auth`) |
| `.api_url` | The URL of the Cycloid API |
