import {
  IsDecimal,
  IsInt,
  IsNotEmpty,
  IsPositive,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';
import { CharacteristicsProductDTO } from './CharacteristicsProduct.dto';
import { ImageProductDTO } from './ImageProduct.dto';

export class CreateProductDTO {
  @IsString()
  @IsNotEmpty({ message: 'O Nome não pode estar vazio.' })
  name: string;

  @IsDecimal({ decimal_digits: '2', locale: 'pt-BR', force_decimal: true })
  @IsNotEmpty({ message: 'O Valor não pode estar vazio.' })
  value: number;

  @IsInt()
  @IsPositive({
    message: 'Quantidade deve ser um valor maior zero ou igual a zero.',
  })
  @IsNotEmpty({ message: 'A Quantidade deve ser valor positivo.' })
  amount: number;

  @IsString()
  @MaxLength(1000, {
    message: 'O Descrição do produto não pode ter mais que 1000 caracteres.',
  })
  @IsNotEmpty({ message: 'O Descrição do produto não pode estar vazio.' })
  description: string;

  @MinLength(3, { message: 'Deve ter pelo menos 3 características' })
  characteristics: CharacteristicsProductDTO[];

  @MinLength(1, { message: 'Deve ter pelo menos 1 imagem' })
  imagens: ImageProductDTO[];

  @IsNotEmpty({ message: 'O Categoria do produto não pode estar vazio.' })
  category: string;
}
