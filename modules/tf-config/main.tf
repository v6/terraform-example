// Module: Linux Bootstrap
data "template_file" "publish" {
    template = "${file("../../scripts/configure_publisher_agents.sh")}"

  vars {
    pubpriv_ips     = "${join(",", var.pubpriv_ips)}"
    auth_ips        = "${join(",", var.auth_ips)}"
    site_dnsname    = "${var.site_dnsname}"
  }
}

data "template_file" "dispatch" {
    template = "${file("../../scripts/configure_dispatcher_agents.sh")}"

  vars {
    disppriv_ips    = "${join(",", var.disppriv_ips)}"
    auth_ips        = "${join(",", var.auth_ips)}"
    site_dnsname    = "${var.site_dnsname}"
  }
}

resource "null_resource" "author_bootstrap_empty" {
  count      = "${var.auth_count}"
  depends_on = ["data.template_file.publish"]

  connection {
    host        = "${element(var.auth_ips, count.index)}"
    type        = "ssh"
    user        = "${var.os_user}"
    private_key = "${file("${var.ssh_private_key_location}")}"
  }

  provisioner "file" {
    content      = "${data.template_file.publish.rendered}"
    destination = "/tmp/configure_publisher_agents.sh"
  }

  provisioner "file" {
    content      = "${data.template_file.dispatch.rendered}"
    destination = "/tmp/configure_dispatcher_agents.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/*.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo /tmp/configure_publisher_agents.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo /tmp/configure_dispatcher_agents.sh"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "sudo rm /tmp/*.sh"
    ]
  }
}

resource "null_resource" "dispatch_bootstrap_empty" {
  count      = "${var.pub_count}"
  # depends_on = ["data.template_file.publish"]

  connection {
    host        = "${element(var.disp_ips, count.index)}"
    type        = "ssh"
    user        = "${var.os_user}"
    private_key = "${file("${var.ssh_private_key_location}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -i s/localhost/${element(var.pubpriv_ips, count.index)}/g /etc/httpd/conf/dispatcher.any"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo service httpd restart"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo rm /tmp/*.sh"
    ]
  }
}

## Needs to pull in all server names, and apply backup policies
# resource "azurerm_recovery_services_protected_vm" "example" {
#   resource_group_name = "${azurerm_resource_group.example.name}"
#   recovery_vault_name = "${azurerm_recovery_services_vault.example.name}"
#   source_vm_id        = "${azurerm_virtual_machine.example.id}"
#   backup_policy_id    = "${azurerm_recovery_services_protection_policy_vm.example.id}"
# }
