<?php
require 'config.php';
header('Location: ' . (user() ? home_for(user()['role']) : 'login.php'));
