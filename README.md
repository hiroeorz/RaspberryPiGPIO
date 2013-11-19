# RaspberryPiGPIO

RaspberryPi GPIO reader, writer, setinterrupter.

## Goals

RaspberryPiGPIO is provide a complete GPIO handler in a small code base.

## Getting Started

Log in your RaspberryPi and fetch the latest version of RaspberryPiGPIO using git.

```
$ git clone https://github.com/hiroeorz/RaspberryPiGPIO.git
$ cd RaspberryPiGPIO
$ make
```

Or add deps line to your app's rebar.conf.

```erlang
{rgpio, ".*", {git, "https://github.com/hiroeorz/RaspberryPiGPIO.git",
   {branch, "master"}}},

```

and get deps

```
$ ./rebar get-deps
```

## Running

check [default setting of gpio](https://github.com/hiroeorz/RaspberryPiGPIO/blob/master/src/rgpio.app.src).

In default setting, under gpio22 is input pin, other is output pin.

You can change pin setting by modifing above file, if you need.

### Start application.

You must run rgpio as root. Because rgpio access to /dev/mem. /dev/mem is allowed writable access from root only.

```
$ sudo ./start-dev
```

```erl-sh
1> rgpio:start().
```

### Read gpio value

```erl-sh
1> rgpio:read(18).
0
```

### Write value to gpio

```erl-sh
1> rgpio:write(18, 1).
ok
2> rgpio:read(18).
1

3> rgpio:write(18, 0).
ok
4> rgpio:read(18).
0
```    

### Pullup or pulldown

```erl-sh
1> rgpio:pullup(18).
ok
2> rgpio:pulldown(18).
ok
3> rgpio:pullnone(18).
ok
```

### Set interrupt
 
```erl-sh
1> rgpio:set_int(18, rising).
ok
2> rgpio:set_int(18, falling).
ok
3> rgpio:set_int(18, both).
ok
4> rgpio:set_int(18, none).
ok
```

### Add event handler

```erl-sh
1> rgpio:add_event_handler(sample_module).
ok
```

The sample_module is event handler befavior of gen_event.
If gpio18 set interrupt rising and pin status changed 0 to 1 , called event handler.

### Get all status list

```erl-sh
1> rgpio:status().
[0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]
```

### Get all status that packed 16bit integer.

```erl-sh
1> rgpio:packed_status().
[16390,0]
```

## Todo

- test
- http rest interface.
- and the other...
