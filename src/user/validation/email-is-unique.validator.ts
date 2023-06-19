import {
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
  registerDecorator,
} from 'class-validator';
import { UserRepository } from '../user.repository';
import { Injectable } from '@nestjs/common';

@Injectable()
@ValidatorConstraint({ async: true })
export class EmailIsUniqueValidator implements ValidatorConstraintInterface {
  constructor(private userRepository: UserRepository) {}

  async validate(
    value: any,
    // validationArguments?: ValidationArguments,
  ): Promise<boolean> {
    const userWithEmailExists = await this.userRepository.existsWithEmail(
      value,
    );

    return !userWithEmailExists;
  }
}

export const EmailIsUnique = (optionsValidation: ValidationOptions) => {
  return (object: object, prop: string) => {
    registerDecorator({
      target: object.constructor,
      propertyName: prop,
      options: optionsValidation,
      constraints: [],
      validator: EmailIsUniqueValidator,
    });
  };
};
