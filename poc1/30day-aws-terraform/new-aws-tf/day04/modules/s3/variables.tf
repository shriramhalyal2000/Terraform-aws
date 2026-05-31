variable "Enviornment" {
    type = "string"
    description = "Enviorment where its used"
    default = "Mt_dev:1.0"
    sensitive =  false #when true hides value from cli output
}