# aws_elb_webserver-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['aws_elb_webserver']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### aws_elb_webserver::default

Include `aws_elb_webserver` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[aws_elb_webserver::default]"
  ]
}
```

## License and Authors

Author:: GE Healthcare (<josh.schneider@ge.com
>)
