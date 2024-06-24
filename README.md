# litter_robot_exporter
Prometheus Exporter for the Whisker Litter Robot 4 Cat Box

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
| `robot_status`                               | Robot status                      |
| `robot_cycle_count`                          | Cycle count                       |

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

Grafana dashboard provided at `litter_robot_dashboard.json` which you can import into Grafana to visualize metrics like this:

Grafana dashboard showing litter box metrics over time:

<img width="1429" alt="Grafana dashboard showing litter box waste levels and litter levels over time" src="https://github.com/geekdave/litter_robot_exporter/assets/1438478/e1f6ae51-3046-4556-b060-79c142e52c75">

A state transition timeline showing litter box statuses over time:

<img width="876" alt="Grafana state transition timeline showing cat litter box statuses over time" src="https://github.com/geekdave/litter_robot_exporter/assets/1438478/f1424694-c8a3-42a3-ae67-8856f1f8b071">

# TODO

1. Alertmanager Rules
2. Heatmap of most popular times the box is used
3. Cat weight visualization