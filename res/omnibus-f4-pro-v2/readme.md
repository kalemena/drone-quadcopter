
# Board notes

Hare are few notes on using the board under linux.

## Setup Configurator

- [Follow linux specific UDEV notes](https://github.com/betaflight/betaflight/wiki/Installing-Betaflight)

```bash
$ (echo '# DFU (Internal bootloader for STM32 MCUs)';  echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="plugdev"') | sudo tee /etc/udev/rules.d/45-stdfu-permissions.rules > /dev/null
$ udevadm monitor --environment --udev | grep ID_MODEL_ID
ID_MODEL_ID=5740
ID_MODEL_ID=5740
$ sudo vi /etc/udev/rules.d/45-stdfu-permissions.rules
$ sudo udevadm control --reload-rules && udevadm trigger
$ udevadm test $(udevadm info -q path -n /dev/ttyACM0)
$ dmesg | grep tty
$ sudo usermod -a -G plugdev clement
```

- Install Chrome betaflight app

- Run the app and connect to /dev/ttyACM0

- You should see the virtual drone move on XYZ axis

![Drone in betaflight](/res/omnibus-f4-pro-v2/drone-betaflight.png)

## Hook and setup Radio

Inspired from [Youtube video - hooking up receiver](https://www.youtube.com/watch?v=pNEyERJ1w_8)

Translated to usage of "FS-A8S" receiver, this brings to:

- Hook UART 1 to FS-A8S with respecting Ground, Vcc and i-Bus to RX UART.

![receiver-fs-a8s](/res/omnibus-f4-pro-v2/receiver-fs-a8s.png)

- Connect board+receiver to Betaflight

- Enable Rx on UART 1

![Enable UART1](/res/omnibus-f4-pro-v2/betaflight-set-receiver-rx-uart1.png)

- Set Receiver to be i-Bus

![Set i-Bus](/res/omnibus-f4-pro-v2/betaflight-set-receiver-i-bus.png)

- Test receiver

![Test Receiver](/res/omnibus-f4-pro-v2/betaflight-test-receiver.png)

