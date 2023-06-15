import { IsString, IsNotEmpty } from 'class-validator';

export class ImageProductDTO {
  @IsString()
  @IsNotEmpty({ message: 'O Url da imagem não pode estar vazio.' })
  url: string;

  @IsString()
  @IsNotEmpty({ message: 'O Descrição da imagem não pode estar vazio.' })
  description: string;
}
