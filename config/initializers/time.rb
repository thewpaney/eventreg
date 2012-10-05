ER::Application.config.time = {
  9 => {open: Time.now, close: Time.at(9999999999)},
  11 => {open: Time.utc(2012, 10, 18, 2, 0), close: Time.utc(2012, 10, 20, 2, 0)},
  12 => {open: Time.utc(2012, 10, 8, 2, 0), close: Time.utc(2012, 10, 10, 2, 0)}
}
