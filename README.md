In version 5.84.0 of terraform-aws-provider using `routing_http_response_server_enabled` parameter on existing resources does not apply header changes to load balancer. When plan with changes like presented below is applied, header attributes are not affected.

```
  # aws_lb_listener.test will be updated in-place
  ~ resource "aws_lb_listener" "test" {
        id                                                                  = "arn:aws:elasticloadbalancing:us-east-1:<account-id>:listener/app/test-lb/<id>"
      ~ routing_http_response_server_enabled                                = true -> false
        tags                                                                = {}
        # (16 unchanged attributes hidden)

        # (1 unchanged block hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.
```

Steps to reproduce:
1. Create infrastructure using configuration from `5.76.0/` directory. Please note, that tfstate will be stored in repo root directory.
1. Apply changes to infrastructure using configuration from `5.84.0/` directory. Plan should show 1 change fo listener, which after apply will not be applied to resource.
    1. If logging is enabled, it should produce log like this:
  ```json
  {"@level":"warn","@message":"Provider \"provider[\\\"registry.terraform.io/hashicorp/aws\\\"]\" produced an unexpected new value for aws_lb_listener.test, but we are tolerating it because it is using the legacy plugin SDK.\n    The following problems may be the cause of any confusing errors from downstream operations:\n      - .routing_http_response_server_enabled: was cty.False, but now cty.True","@timestamp":"2025-01-17T12:58:04.550456+01:00"}
  ``` 