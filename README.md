# litter_robot_exporter
Prometheus Exporter for the Whisker Litter Robot 4 Cat Box

<img width="1429" alt="Grafana dashboard showing litter box waste levels and litter levels over time" src="https://github.com/geekdave/litter_robot_exporter/assets/1438478/e1f6ae51-3046-4556-b060-79c142e52c75">

# Setup

## Requirements

* Python
* Litter Robot username & password

## Install

* Run `pip3 install -r requirements.txt`
* Set `ROBOT_API_USERNAME` and `ROBOT_API_PASSWORD` to your credentials
* Optional: Set `POLLING_INTERVAL_SECONDS` to a different interval (default is `60s`)

## Run

Run `python3 exporter.py`

## Metrics exposed:

| Metric Name                                  | Description                       |
|----------------------------------------------|-----------------------------------|
| `robot_litter_level`                         | Litter level                      |
| `robot_waste_drawer_level`                   | Waste drawer level                |
| `robot_is_drawer_full_indicator_triggered`   | Drawer full indicator triggered   |
| `robot_is_online`                            | Is online                         |
| `robot_is_sleeping`                          | Is sleeping                       |
| `robot_is_waste_drawer_full`                 | Is waste drawer full              |
| `robot_cycle_count`                          | Cycle count                       |

## Labels

All metrics are also decorated with these labels:

| Label Name           | Description                       |
|----------------------|-----------------------------------|
| `robot_id`           | Unique identifier for the robot   |
| `robot_name`         | Name of the robot                 |
| `robot_model`        | Model of the robot                |
| `robot_serial_number`| Serial number of the robot        |
| `robot_status`       | Current status of the robot       |

## Statuses

Here are the possible robot statuses for the `robot_status` label.  These are used by the state transition timeline in the dashboard:

| Status Key         | Status Description |
|--------------------|--------------------|
| `BONNET_REMOVED`   | Bonnet Removed     |
| `CAT_DETECTED`     | Cat Detected       |
| `CAT_SENSOR_TIMING`| Cat Sensor Timing  |
| `CLEAN_CYCLE`      | Clean Cycle        |
| `EMPTY_CYCLE`      | Empty Cycle        |
| `READY`            | Ready              |
| `POWER_DOWN`       | Power Down         |
| `OFF`              | Off                |
| `POWER_UP`         | Power Up           |
| `DRAWER_FULL`      | Drawer Full        |

# Grafana Cloud Integration

## Install Alloy

Install Grafana Alloy to collect metrics and forward to Grafana Cloud

## Configure Alloy

Modify `/etc/alloy/config.alloy` to add a section like this to scrape the litter exporter and forward
to Grafana Cloud's Prometheus

```
prometheus.scrape "whisker" {
  targets    = [
    {
      __address__ = "localhost:9877",
    },
  ]
  forward_to = [prometheus.remote_write.metrics_hosted_prometheus.receiver]
}
```

# Dashboard

Grafana dashboard provided at `litter_robot_dashboard.json` which you can import into Grafana to visualize metrics:

A state transition timeline showing litter box statuses over time:

<img width="876" alt="Grafana state transition timeline showing cat litter box statuses over time" src="https://github.com/geekdave/litter_robot_exporter/assets/1438478/f1424694-c8a3-42a3-ae67-8856f1f8b071">

# TODO

1. Alertmanager Rules
2. Heatmap of most popular times the box is used
3. Cat weight visualization

# Thanks

This project is inspired by Traci Kamp's [litter-exporter](https://github.com/tlkamp/litter-exporter) project which supports the Litter Robot 3 and is written in Go.

The API interface is powered by the [pylitterbot](https://github.com/natekspencer/pylitterbot) project by 
Nathan Spencer.

# License

The MIT License