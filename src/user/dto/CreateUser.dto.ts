import { IsEmail, IsNotEmpty, IsString, MinLength } from 'class-validator';

export class CreateUserDTO {
  @IsString()
  @IsNotEmpty({ message: 'O Nome não pode estar vazio.' })
  name: string;

  @IsEmail(undefined, { message: 'O e-mail informado não é valido.' })
  @IsNotEmpty({ message: 'O e-mail não pode estar vazio.' })
  email: string;

  @MinLength(6, { message: 'A senha precisa ter pelo menos 6 caracteres' })
  @IsNotEmpty({ message: 'O senha não pode estar vazia.' })
  password: string;
}
