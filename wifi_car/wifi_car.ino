int Left_motor = 8;
int Left_motor_pwm = 9;

int Right_motor_pwm = 10;
int Right_motor = 11;
String in_data = "0";

int ServoPinTurn = 12;
int ServoTurnPosition = 135;

int ServoPinUpDown = 2;
int ServoUpDownPosition = 0;

void setup()
{
  Serial.begin(9600);
  Serial.flush();

  pinMode(ServoPinTurn, OUTPUT);
  pinMode(ServoPinUpDown, OUTPUT);

  pinMode(Left_motor, OUTPUT); // PIN 8
  pinMode(Left_motor_pwm, OUTPUT); // PIN 9 (PWM)
  pinMode(Right_motor_pwm, OUTPUT); // PIN 10 (PWM)
  pinMode(Right_motor, OUTPUT); // PIN 11 (PWM)

  movePulse(ServoPinTurn, ServoTurnPosition);
  movePulse(ServoPinUpDown, ServoUpDownPosition);
}

int a = 1;

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
  int degree = 0;
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
  else if (data.indexOf("cud") != -1)
  {
    data.replace("cud", "");
    int degree = data.toInt();
    servoMove(ServoPinUpDown, degree);
  }
  else if (data.indexOf("ct") != -1)
  {
    data.replace("ct", "");
    int degree = data.toInt();
    servoMove(ServoPinTurn, degree);
  }
}

//servo.h лочик порты управления колёсами для своих нужд
//поэтому управляем мотором вручную
void servoMove(int pin, int degreesCount)
{
  int maxAngle;
  if (pin == ServoPinTurn ) {
    maxAngle = 360;
  } else {
    maxAngle = 100;
  }

  if (degreesCount < 0 || degreesCount > maxAngle) {
    return;
  }

  movePulse(degreesCount, pin);
  if (pin == ServoPinTurn ) {
    ServoTurnPosition = degreesCount;
  } else {
    ServoUpDownPosition = degreesCount;
  }
}

void movePulse(int x, int pin) {
  int fr = 18900;
  if (x > 90) {
    int fr = 18100;
  }

  int del = (5 * x) + 400;
  for (int pulseCounter = 0; pulseCounter <= 50; pulseCounter++) {
    digitalWrite(pin, HIGH);
    delayMicroseconds(del);    //position
    digitalWrite(pin, LOW);
    delayMicroseconds(fr);   //balance of 20000 cycle
  }
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
