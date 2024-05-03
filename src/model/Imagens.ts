import { Table, Column, Model } from 'sequelize-typescript';

@Table
export class imagens extends Model {
  @Column({ primaryKey: true, autoIncrement: true })
  id_imagem: number;

  @Column({ type: 'bytea' })
  imagem: Buffer;

  @Column({ type: 'text' })
  descricao: string;
}
