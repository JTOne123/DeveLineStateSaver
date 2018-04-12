﻿namespace DeveLineStateSaver.Tests
{
    public class TestCounter
    {
        public int CallCount { get; private set; }

        public int SimpleCall(int input)
        {
            CallCount++;
            return input * 2;
        }

        public int SimpleUnrelatedCall(int input)
        {
            return input;
        }

        public ComplexObjectTest ComplexCall(ComplexObjectTest input)
        {
            CallCount++;

            var retval = new ComplexObjectTest()
            {
                Age = input.Age.AddDays(5),
                Name = input.Name + "blah",
                Timer = input.Timer + 100
            };

            return retval;
        }

        public ComplexObjectTest ComplexUnrelatedCall(ComplexObjectTest input)
        {
            return input;
        }
    }
}
