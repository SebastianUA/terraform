#---------------------------------------------------
# Create compute instance template
#---------------------------------------------------
resource "google_compute_instance_template" "compute_instance_template" {

    name                    = "${length(var.name) > 0 ? "${lower(var.name)}-template-${lower(var.environment)}" : "" }"
    #name_prefix             = ""
    description             = "${var.description}"

    project                 = "${var.project}"
    region                  = "${var.region}"

    machine_type            = "${var.machine_type}"
    instance_description    = "${var.instance_description}"
    min_cpu_platform        = "${var.min_cpu_platform}"
    can_ip_forward          = "${var.can_ip_forward}"

    metadata {
        ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
    }

    metadata_startup_script = "${file("${path.module}/${var.install_script_src_path}")}"


    network_interface {
        network             = "${var.subnetwork == "" ? var.network : ""}"
        subnetwork          = "${var.subnetwork}"
        subnetwork_project  = "${var.subnetwork_project}"
        address             = "${var.address}"

        alias_ip_range {
            ip_cidr_range              = "${var.alias_ip_range_ip_cidr_range}"
            subnetwork_range_name      = "${var.alias_ip_range_subnetwork_range_name}"
        }

        access_config {
            nat_ip                  = "${var.nat_ip}"
            network_tier            = "${var.network_tier}"
        }
    }

    disk {
        auto_delete     = "${var.disk_auto_delete}"
        boot            = "${var.disk_boot}"
        device_name     = "${var.disk_device_name}"
        disk_name       = "${var.disk_disk_name}"
        source_image    = "${var.disk_source_image}"
        interface       = "${var.disk_interface}"
        mode            = "${var.disk_mode}"
        source          = "${var.disk_source}"
        disk_type       = "${var.disk_disk_type}"
        disk_size_gb    = "${var.disk_disk_size_gb}"
        type            = "${var.disk_type}"
    }

    service_account {
        email   = "${var.service_account_email}"
        scopes  = "${var.service_account_scopes}"
    }

    scheduling {
        preemptible         = "${var.scheduling_preemptible}"
        on_host_maintenance = "${var.scheduling_on_host_maintenance}"
        automatic_restart   = "${var.scheduling_automatic_restart}"
    }

    guest_accelerator {
        type    = "${var.guest_accelerator_type}"
        count   = "${var.guest_accelerator_count}"
    }

    tags = [
        "${lower(var.name)}",
        "${lower(var.environment)}",
        "${lower(var.orchestration)}"
    ]

    labels {
        name            = "${lower(var.name)}-template-${lower(var.environment)}"
        environment     = "${lower(var.environment)}"
        orchestration   = "${lower(var.orchestration)}"
    }

    lifecycle {
        ignore_changes = [
            "network_interface",
        ]
        create_before_destroy = true
    }

}
