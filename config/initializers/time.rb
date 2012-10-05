ER::Application.config.time = {
  9 => {open: Time.now, close: Time.now + 1.month},
  11 => {open: Time.utc(2012, 10, 17, 20, 0), close: Time.utc(2012, 10, 19, 20, 0)},
  12 => {open: Time.utc(2012, 10, 7, 20, 0), close: Time.utc(2012, 10, 9, 20, 0)}
}
