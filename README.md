# Qt Automotive Tachometer

An automotive RPM tachometer prototype built with **Qt 6, C++ and QML**. The project demonstrates a custom-drawn instrument cluster, a smoothly animated needle, and a simulated engine data source.

> **Project status:** Functional desktop prototype. This is **not** a production-ready vehicle instrument cluster and has not been validated on automotive hardware.

## Preview

Add a screenshot of the running application at `docs/tachometer-preview.png`, then uncomment the following line:

<!-- ![Tachometer preview](docs/tachometer-preview.png) -->

## Features

- Custom RPM dial rendered using QML Canvas
- Major and minor tick marks with high-RPM visual highlighting
- Animated needle driven by a QML property
- C++ `EngineSimulator` exposed to QML using `Q_PROPERTY`
- Simulated acceleration and deceleration
- Keyboard interaction: hold **Space** or **Up Arrow** to accelerate; release to decelerate
- Resizable desktop UI

## Technology Stack

| Layer | Technology | Responsibility |
| --- | --- | --- |
| Application | Qt 6 / Qt Quick | Window and UI runtime |
| Visualization | QML / Canvas | Dial, labels, needle and animations |
| Simulation | C++ / QObject / QTimer | Generate mock RPM values |
| Integration | Qt properties and signals | Deliver RPM updates to QML |
| Build | CMake | Configure and compile the application |

## Architecture

```text
+-----------------------------+
|     EngineSimulator (C++)   |
|  RPM / acceleration / timer |
+--------------+--------------+
               |
       Q_PROPERTY + signals
               |
+--------------v--------------+
|         QML UI              |
|   Dial / ticks / needle     |
|     animated RPM view       |
+-----------------------------+
```

The simulation is intentionally separate from the UI. A future integration can replace the simulated RPM source with an approved vehicle-data interface without rewriting the gauge visuals.

## Requirements

- Qt 6 with Qt Quick and Qt Quick Controls
- C++17-compatible compiler (or newer)
- CMake
- Qt Creator (recommended)

## Build and Run

1. Clone the repository:

   ```bash
   git clone https://github.com/<YOUR_USERNAME>/qt-automotive-tachometer.git
   cd qt-automotive-tachometer
   ```

2. Open `CMakeLists.txt` in **Qt Creator**.
3. Select a configured **Qt 6 Desktop Kit**.
4. Configure, build and run the project.

Alternatively, if Qt 6 is discoverable by CMake:

```bash
cmake -S . -B build
cmake --build build
```

> The CMake target and QML module URI must match the names used in this repository's actual `CMakeLists.txt` and `main.cpp`.

## Controls

| Action | Control |
| --- | --- |
| Accelerate | Hold `Space` or `Up Arrow` |
| Decelerate | Release the key |

RPM values are **simulated**; no physical ECU or vehicle network is connected.

## Vehicle Integration — Proposed, Not Implemented

A possible future architecture is:

```text
Vehicle ECU
    |
Approved vehicle gateway / CAN interface
    |
Validated signal decoder (vehicle-specific mapping)
    |
RPM data provider (C++)
    |
Qt property / signal interface
    |
QML Tachometer
```

Actual integration requires the vehicle manufacturer's interface specifications, approved hardware, signal definitions (such as a DBC where applicable), appropriate authorization, and testing on a safe bench setup before any vehicle deployment. The current application **does not implement CAN, SocketCAN, ECU communication, diagnostics, or safety certification**.

## Roadmap

- [x] Initial custom QML tachometer
- [x] C++ engine RPM simulation
- [x] QML/C++ property binding
- [x] Animated needle and keyboard acceleration
- [ ] Correct dial numbering/orientation to match the reference design
- [ ] Refine metallic bezel, lighting and visual fidelity
- [ ] Extract a reusable `Tachometer.qml` component
- [ ] Add automated tests and input validation
- [ ] Implement an abstract RPM data-provider interface
- [ ] Evaluate authorized vehicle-data integration on a bench rig
- [ ] Measure performance on target embedded hardware

## Engineering Notes

This project is intended for **HMI prototyping, Qt/QML learning and engineering demonstrations**. It must not be relied upon to display safety-critical driving information. Production deployment would require a separate engineering and verification effort addressing real-time behavior, signal validity, failure handling, hardware constraints, and applicable automotive safety and cybersecurity requirements.

## License

No license is included by default. Add a `LICENSE` file if you want to define reuse and contribution permissions.
