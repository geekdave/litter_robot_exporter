# litter_robot_exporter
[Prometheus](https://prometheus.io/) Exporter for the [Whisker Litter Robot 4](https://www.litter-robot.com/) Smart Cat Litter Box

<img width="1429" alt="Grafana dashboard showing litter box waste levels and litter levels over time" src="https://github.com/geekdave/litter_robot_exporter/assets/1438478/b02ec43c-dbf1-40d2-bd52-ceda99578bb4">

# Why?

The stock Litter Robot app already provides: 

1. The *current* percentages of clean litter and waste drawer fullness
1. Alerts for when the drawer is almost full, and full, as well as when the clean litter level is low

What's missing is:

1. The ability to track clean litter and waste drawer levels over time, to understand trends.  It's also helpful to know this information if you'll be having a cat-sitter take over duties and need to let them know how often they should expect to refill clean litter and empty the waste drawer.
1. Predictive alerts such as "waste drawer expected to fill in 24 hours" in case you'll be away for a day, and need a nudge to proactively empty the tray
3. A super geeky dashboard 

I created this exporter to fill in the missing gaps, and also to have fun and learn more about some of Grafana's new features such as the state transition timeline, and the [Alloy](https://grafana.com/docs/alloy/latest/) data collector.

# Support 

## Models

Currently only the Litter Robot 4 is supported because that's the only model that I have access to.  The Litter Robot 3 should also be possible, as it is supported by the underlying [pylitterbot](https://github.com/natekspencer/pylitterbot) library.  If you have a Litter Robot 3 and and interested in contributing, PRs are most welcome!

## Disclaimer

This exporter is not endorsed or supported by Whisker, and may cease to work at any time. Use at your own risk.  It is intended for entertainment and informational purposes only and is not intended for mission-critical production cat litter boxes.

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