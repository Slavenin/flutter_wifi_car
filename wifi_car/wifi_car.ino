int Left_motor = 8;
int Left_motor_pwm = 9;

int Right_motor_pwm = 10;
int Right_motor = 11;
String in_data = "0";

void setup()
{
  Serial.begin(9600);
  Serial.flush();
  pinMode(Left_motor, OUTPUT); // PIN 8
  pinMode(Left_motor_pwm, OUTPUT); // PIN 9 (PWM)
  pinMode(Right_motor_pwm, OUTPUT); // PIN 10 (PWM)
  pinMode(Right_motor, OUTPUT); // PIN 11 (PWM)
}
void run()
{
  digitalWrite(Right_motor, LOW);
  digitalWrite(Right_motor_pwm, HIGH);
  analogWrite(Right_motor_pwm, 150);

  digitalWrite(Left_motor, LOW);
  digitalWrite(Left_motor_pwm, HIGH);
  analogWrite(Left_motor_pwm, 150);
}

void brake()
{

  digitalWrite(Right_motor_pwm, LOW);
  analogWrite(Right_motor_pwm, 0);

  digitalWrite(Left_motor_pwm, LOW);
  analogWrite(Left_motor_pwm, 0);
}

void left()
{
  digitalWrite(Right_motor, LOW);
  digitalWrite(Right_motor_pwm, HIGH);
  analogWrite(Right_motor_pwm, 150);


  digitalWrite(Left_motor, LOW);
  digitalWrite(Left_motor_pwm, LOW);
  analogWrite(Left_motor_pwm, 0);
}

void spin_left()
{
  digitalWrite(Right_motor, LOW);
  digitalWrite(Right_motor_pwm, HIGH);
  analogWrite(Right_motor_pwm, 150);

  digitalWrite(Left_motor, HIGH);
  digitalWrite(Left_motor_pwm, HIGH);
  analogWrite(Left_motor_pwm, 150);
}

void right()
{
  digitalWrite(Right_motor, LOW);
  digitalWrite(Right_motor_pwm, LOW);
  analogWrite(Right_motor_pwm, 0);


  digitalWrite(Left_motor, LOW);
  digitalWrite(Left_motor_pwm, HIGH);
  analogWrite(Left_motor_pwm, 150);
}

void spin_right()
{
  digitalWrite(Right_motor, HIGH);
  digitalWrite(Right_motor_pwm, HIGH);
  analogWrite(Right_motor_pwm, 150);


  digitalWrite(Left_motor, LOW);
  digitalWrite(Left_motor_pwm, HIGH);
  analogWrite(Left_motor_pwm, 150);
}

void back()
{
  digitalWrite(Right_motor, HIGH);
  digitalWrite(Right_motor_pwm, HIGH);
  analogWrite(Right_motor_pwm, 150);


  digitalWrite(Left_motor, HIGH);
  digitalWrite(Left_motor_pwm, HIGH);
  analogWrite(Left_motor_pwm, 150);
}

void loop()
{
  if (Serial.available() > 0)
  {
    in_data = Serial.readStringUntil('\n');
    doCommand(in_data);
  }
}


void doCommand(String data)
{

  if (data == "fw") {
    run();
  } else if (data == "bw") {
    back();
  } else if (data == "lf") {
    left();
  } else if (data == "rg") {
    right();
  } else if (data == "st") {
    brake();
  }
}
