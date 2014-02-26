#!/bin/sh
SERVICE=$1

kill -9 $(pidof $SERVICE)
