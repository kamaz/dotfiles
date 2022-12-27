local status_ok, filetype = pcall(require, "filetype")
if not status_ok then
  return
end

local setup = {
  overrides = {
    extensions = {
      tf = "terraform",
      tfvars = "terraform",
      hcl = "terraform",
      tfstate = "json",
    }
  }
}

filetype.setup(setup)

