source "azure-arm" "test" {
    os_type = "Linux"
    image_publisher = "Canonical"
    image_offer = "0001-com-ubuntu-server-jammy"
    image_sku = "22_04-lts"

    build_resource_group_name= "big-test-rg"
    managed_image_resource_group_name = "big-test-rg"
    managed_image_name = "packer-test"

    client_id = "c0b02a95-5b56-47e3-ac88-279f838ed445"
    client_secret = "dM78Q~13rDmEHAHcN0wRm.xWvlZ.74_3B-oQ_c6a"
    subscription_id = "df7b52cf-72b5-4784-9874-85af8d8adb24"
    tenant_id = "9354bc5f-1841-48b3-bbdb-3a00098ea71f"

    vm_size = "Standard_B1s"
}

build {
    sources = ["source.azure-arm.test"]

    provisioner "ansible" {
        playbook_file = "./playbooks/common-pre.yml"
        use_proxy = false
    }

    provisioner "ansible" {
        playbook_file = "./playbooks/install-vault.yml"
        use_proxy = false
    }

    provisioner "ansible" {
        playbook_file = "./playbooks/setup-firewall.yml"
        use_proxy = false
    }
}