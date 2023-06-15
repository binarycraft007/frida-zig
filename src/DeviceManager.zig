const c = @import("c.zig");
const DeviceManager = @This();

manager: *c.FridaDeviceManager,

pub fn init() !DeviceManager {
    if (c.frida_device_manager_new()) |manager| {
        return .{ .manager = manager };
    }
    return error.DeviceManagerInitFailed;
}

pub fn close(self: *DeviceManager) void {
    _ = self;
}

pub fn deinit(self: *DeviceManager) void {
    c.frida_unref(self.manager);
}

test "init/deinit" {
    var mgr = try DeviceManager.init();
    defer mgr.deinit();
}
