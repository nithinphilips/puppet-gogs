siteminds/gogs
==============

[![Travis build status](https://api.travis-ci.org/Siteminds/puppet-gogs.svg)](https://travis-ci.org/Siteminds/puppet-gogs)

Overview
--------

This is a Puppet module to install Gogs (Go Git Service, see: <http://gogs.io>).

Module Description
-------------------

Gogs(Go Git Service) is a painless self-hosted Git Service written in Go. The goal of the Gogs
project is to make the easiest, fastest and most painless way to set up a self-hosted Git service.
With Go, this can be done in independent binary distribution across ALL platforms that Go supports,
including Linux, Mac OS X, and Windows.

This Puppet module allows you to manage the Gogs service on linux operating systems. Currently
only Debian and RedHat family linux is tested/supported.

Usage
-----



Special Notes
-------------

This module does *not* install a database required by Gogs. Please provide your own wrapper or
server role module to install either a Postgresql or MySql database. Sqlite3 is not supported
by the packages provided on packager.io. If you provide your own package (install_repo = false),
you can ofcourse set the db_type to sqlite3.

Another Gogs quirk is that it does not install an admin user by default. Normally this is done
by the first time installer, which configures an admin user in the database. Since this module
deliberately does not install a database, you should either add a Gogs admin user to the
database with another module or manually. An example SQL insert for this is:

    INSERT INTO "user" VALUES (1, 'admin', 'admin', '', 'my@admin.com', 'someverylongPDKDF2passwordhash', 0, 0, '', 0, '', '', 'randomsecret', 'randomsaltstring', '2015-01-07 13:58:37', '2015-01-07 13:58:37', true, true, false, '9075fd3adc2d47bc1ae87100e0686399', 'my@admin.com', false, 0, 0, 0, 0, '', 0, 0);`

The password must be a PDKDF2 encrypted string, using 10000 iterations, keylength 50, the salt
value (in this case 'randomsaltstring') and SHA-256 HMAC. You could use the following Go program
to generate a password hash:

    package main

    import (
           "fmt"
           "os"
           "crypto/sha256"
           "github.com/gogits/gogs/modules/base"
    )

    func main() {
       newPasswd := base.PBKDF2([]byte(os.Args[1]), []byte(os.Args[2]), 10000, 50, sha256.New)
       fmt.Printf("%x\n", newPasswd)
    }

This simple program takes the password as the first argument and the salt value as the second
argument. This code is an actual copy of the Gogs code responsible for inserting/updating
passwords in the database.
