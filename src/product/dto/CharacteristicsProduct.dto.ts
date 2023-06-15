import { IsString, IsNotEmpty } from 'class-validator';

export class CharacteristicsProductDTO {
  @IsString()
  @IsNotEmpty({ message: 'O Nome da caracteristica não pode estar vazio.' })
  name: string;

  @IsString()
  @IsNotEmpty({
    message: 'O Descrição da caracteristica não pode estar vazio.',
  })
  description: string;
}
