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