# Compiling Molar

## Dependencies

- Qt6

## Build

```bash
mkdir build
cd build

cmake .. -DKDDockWidgets_QT6=true -DKDDockWidgets_QTQUICK=true -DKDDockWidgets_EXAMPLES=false
make -j3
```
